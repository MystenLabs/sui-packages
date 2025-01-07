module 0x97024deaa8f2e3fd5ad5beec8de5545270eb5ac1be68eeab9ad482cfca8366ea::mongs {
    struct MONGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONGS>(arg0, 6, b"MS2.0", b"MONGSUI2.0", b"https://t.me/MongSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/h0omlTj.jpg"))), arg1);
        let v2 = v0;
        let v3 = @0xb62c72bccb08cefa83800ada114d1acad03f7a2ceafc37732f60b473a7d3e48d;
        0x2::coin::mint_and_transfer<MONGS>(&mut v2, 100000000000000, v3, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONGS>>(v2, v3);
    }

    // decompiled from Move bytecode v6
}

