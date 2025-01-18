module 0x41a310ef54518f12b8e1dbd0ea2dca8d37b73a32c2cc8f457be853f5a2b0df63::btrump {
    struct BTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTRUMP>(arg0, 9, b"BTRUMP", b"OFFICIAL BABY TRUMP", b"FIGHT BABY FIGHT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNQZBGVn6ZEoZPEGaEctn64GFcksEPhtzCrQkzqsmnNBP")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BTRUMP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTRUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTRUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

