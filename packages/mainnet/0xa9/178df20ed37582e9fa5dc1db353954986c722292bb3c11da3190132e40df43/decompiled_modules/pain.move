module 0xa9178df20ed37582e9fa5dc1db353954986c722292bb3c11da3190132e40df43::pain {
    struct PAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAIN>(arg0, 9, b"PAIN", b"PAIN On Sui", b"NO PAIN, NO GAIN.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/i2vyrA50OCT5LtfZqZSctKNaFztsEJ6djFDmW4Vp3vU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PAIN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

