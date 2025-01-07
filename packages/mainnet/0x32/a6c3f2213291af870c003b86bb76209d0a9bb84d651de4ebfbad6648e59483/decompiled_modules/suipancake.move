module 0x32a6c3f2213291af870c003b86bb76209d0a9bb84d651de4ebfbad6648e59483::suipancake {
    struct SUIPANCAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPANCAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPANCAKE>(arg0, 6, b"SUIPancake", b"SEA Pancake", x"417320492077617320747279696e6720746f2064657363726962652074797065206f66206d6172696e6520616e696d616c204920636f756c646e74207468696e6b206f6620697473206e616d6520736f2049207361696420245355492070616e63616b652e200a0a4d616e7461205261792069732074686520776f7264204920776173206c6f6f6b696e6720666f722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_18_09_58_834ed6d008.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPANCAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPANCAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

