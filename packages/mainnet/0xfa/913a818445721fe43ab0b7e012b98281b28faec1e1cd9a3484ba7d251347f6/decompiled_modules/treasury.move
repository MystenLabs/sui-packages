module 0xfa913a818445721fe43ab0b7e012b98281b28faec1e1cd9a3484ba7d251347f6::treasury {
    struct Treasury<phantom T0: store> has key {
        id: 0x2::object::UID,
        tc: 0x2::coin::TreasuryCap<T0>,
        cooldown_volume: u64,
        last_volume_claim_timestamp: u64,
        volume_mint_val_cap: u64,
    }

    public fun new<T0: store>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury<T0>{
            id                          : 0x2::object::new(arg1),
            tc                          : arg0,
            cooldown_volume             : 0,
            last_volume_claim_timestamp : 0,
            volume_mint_val_cap         : 10000,
        };
        0x2::transfer::share_object<Treasury<T0>>(v0);
    }

    public fun mint_for_boosterpool<T0: store>(arg0: &mut Treasury<T0>, arg1: u64, arg2: &0xfa913a818445721fe43ab0b7e012b98281b28faec1e1cd9a3484ba7d251347f6::admin::BoosterPoolCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0xfa913a818445721fe43ab0b7e012b98281b28faec1e1cd9a3484ba7d251347f6::admin::is_booster_whitelisted(arg2, &v0), 1);
        0x2::coin::mint<T0>(&mut arg0.tc, arg1, arg3)
    }

    public fun mint_for_volume<T0: store>(arg0: &mut Treasury<T0>, arg1: u64, arg2: &0xfa913a818445721fe43ab0b7e012b98281b28faec1e1cd9a3484ba7d251347f6::admin::VolumeCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::clock::timestamp_ms(arg3) - arg0.last_volume_claim_timestamp > arg0.cooldown_volume, 0);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0xfa913a818445721fe43ab0b7e012b98281b28faec1e1cd9a3484ba7d251347f6::admin::is_volume_whitelisted(arg2, &v0), 1);
        assert!(arg0.volume_mint_val_cap >= arg1, 2);
        arg0.last_volume_claim_timestamp = 0x2::clock::timestamp_ms(arg3);
        0x2::coin::mint<T0>(&mut arg0.tc, arg1, arg4)
    }

    public fun set_volume_cooldown<T0: store>(arg0: &mut Treasury<T0>, arg1: u64, arg2: &0xfa913a818445721fe43ab0b7e012b98281b28faec1e1cd9a3484ba7d251347f6::admin::AdminCap) {
        arg0.cooldown_volume = arg1;
    }

    // decompiled from Move bytecode v6
}

