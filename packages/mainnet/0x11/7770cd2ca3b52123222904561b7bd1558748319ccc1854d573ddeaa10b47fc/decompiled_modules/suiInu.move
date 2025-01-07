module 0x117770cd2ca3b52123222904561b7bd1558748319ccc1854d573ddeaa10b47fc::suiInu {
    struct SUIINU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIINU>, arg1: 0x2::coin::Coin<SUIINU>) {
        0x2::coin::burn<SUIINU>(arg0, arg1);
    }

    fun init(arg0: SUIINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIINU>(arg0, 6, b"SUIINU", b"The first inu on Sui Network", b"Twitter: @suiinu_token, Telegram: t.me/suiinuportal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1653631413168803840/oTgTgQ4__400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIINU>>(v1);
        0x2::coin::mint_and_transfer<SUIINU>(&mut v2, 250000000000000, 0x2::address::from_u256(31642622324138137029603384283373467255659561939584750006672470262840863485027), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIINU>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIINU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIINU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

