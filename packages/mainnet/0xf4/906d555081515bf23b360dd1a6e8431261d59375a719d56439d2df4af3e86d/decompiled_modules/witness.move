module 0xf4906d555081515bf23b360dd1a6e8431261d59375a719d56439d2df4af3e86d::witness {
    struct CommonWitness has drop {
        dummy_field: bool,
    }

    struct AssetCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct Asset<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        amount: u64,
    }

    struct WITNESS has drop {
        dummy_field: bool,
    }

    public fun burn<T0: drop>(arg0: &AssetCap<T0>, arg1: Asset<T0>) {
        let Asset {
            id     : v0,
            amount : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    fun init(arg0: WITNESS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = new_asset_cap<WITNESS>(&arg0, arg1);
        0x2::transfer::public_transfer<AssetCap<WITNESS>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint<T0: drop>(arg0: &AssetCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Asset<T0>{
            id     : 0x2::object::new(arg2),
            amount : arg1,
        };
        0x2::transfer::public_transfer<Asset<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    fun new_asset_cap<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : AssetCap<T0> {
        if (!0x2::types::is_one_time_witness<T0>(arg0)) {
            abort 0
        };
        AssetCap<T0>{id: 0x2::object::new(arg1)}
    }

    // decompiled from Move bytecode v6
}

