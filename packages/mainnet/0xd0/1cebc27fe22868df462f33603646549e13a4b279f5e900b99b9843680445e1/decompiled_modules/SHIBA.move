module 0xd01cebc27fe22868df462f33603646549e13a4b279f5e900b99b9843680445e1::SHIBA {
    struct SHIBA has drop {
        dummy_field: bool,
    }

    struct SHIBAInfo has key {
        id: 0x2::object::UID,
        mint_cap: 0x2::coin::TreasuryCap<SHIBA>,
    }

    fun init(arg0: SHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBA>(arg0, 6, b"SHIBA", b"SHIBA Token", b"SHIBA Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sui-img.4everland.store/sui-shiba.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIBA>>(v1);
        let v3 = SHIBAInfo{
            id       : 0x2::object::new(arg1),
            mint_cap : v2,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<SHIBA>>(0x2::coin::mint<SHIBA>(&mut v2, 100000000000000000, arg1), @0x33f64122713994fffe2c2aa71872f9142e39ce035616826f448d6df9f519deb8);
        0x2::transfer::share_object<SHIBAInfo>(v3);
    }

    // decompiled from Move bytecode v6
}

