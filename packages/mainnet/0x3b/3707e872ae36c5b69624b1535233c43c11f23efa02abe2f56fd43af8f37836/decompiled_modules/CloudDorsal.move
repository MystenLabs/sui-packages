module 0x3b3707e872ae36c5b69624b1535233c43c11f23efa02abe2f56fd43af8f37836::CloudDorsal {
    struct CLOUDDORSAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOUDDORSAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOUDDORSAL>(arg0, 0, b"COS", b"Cloud-Dorsal", b"At night, the tide will pull me up, take me back... guide me to...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Cloud-Dorsal.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLOUDDORSAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOUDDORSAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

