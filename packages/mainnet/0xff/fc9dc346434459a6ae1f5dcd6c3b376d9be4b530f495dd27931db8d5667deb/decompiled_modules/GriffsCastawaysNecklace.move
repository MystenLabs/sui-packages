module 0xfffc9dc346434459a6ae1f5dcd6c3b376d9be4b530f495dd27931db8d5667deb::GriffsCastawaysNecklace {
    struct GRIFFSCASTAWAYSNECKLACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRIFFSCASTAWAYSNECKLACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRIFFSCASTAWAYSNECKLACE>(arg0, 0, b"COS", b"Griff's Castaway's Necklace", b"A reminder to keep Them going... a distant memory... of home...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Griffs_Castaways_Necklace.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRIFFSCASTAWAYSNECKLACE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRIFFSCASTAWAYSNECKLACE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

