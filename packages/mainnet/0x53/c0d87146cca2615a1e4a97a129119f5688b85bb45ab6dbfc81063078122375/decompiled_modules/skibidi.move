module 0x53c0d87146cca2615a1e4a97a129119f5688b85bb45ab6dbfc81063078122375::skibidi {
    struct SKIBIDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKIBIDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKIBIDI>(arg0, 9, b"SKBDI", b"Skibidi Toile", b"Skibidi on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776302161130-88ccbbb37f4ccb2e59b3cd8db856fdb0.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SKIBIDI>>(0x2::coin::mint<SKIBIDI>(&mut v2, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKIBIDI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKIBIDI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

