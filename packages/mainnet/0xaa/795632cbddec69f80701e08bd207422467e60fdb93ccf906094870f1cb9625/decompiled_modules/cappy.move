module 0xaa795632cbddec69f80701e08bd207422467e60fdb93ccf906094870f1cb9625::cappy {
    struct CAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPPY>(arg0, 9, b"CAPPY", b"SUI CAPPYBARA", b"SUI CAPPYBARA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1861363623807098880/nncoebF3.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CAPPY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAPPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPPY>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

