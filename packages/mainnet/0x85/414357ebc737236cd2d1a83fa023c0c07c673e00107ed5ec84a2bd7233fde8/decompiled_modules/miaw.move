module 0x85414357ebc737236cd2d1a83fa023c0c07c673e00107ed5ec84a2bd7233fde8::miaw {
    struct MIAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIAW>(arg0, 9, b"MIAW", b"Miaw On Sui", b"Silly Cat, Serious Potential  https://www.miawonsui.fun/  https://t.me/miawonsuiportal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1728921529211-306d478172353db4e5ea1fe6530e5a92.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MIAW>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIAW>>(v2, @0xc4fa7a16cf3895554a03ffc4af30146219abd91717b376327fe0407cd2a72296);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

