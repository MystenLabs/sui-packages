module 0x9ecbb4594777f798eb6a9676a1b6daa224ec070076953e276880c027f60c853d::wormy {
    struct WORMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WORMY>(arg0, 9, b"WORMY", b"WORMY", b"WORMY MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.vecteezy.com/system/resources/previews/012/070/354/non_2x/worms-from-the-ground-cartoon-free-vector.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WORMY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WORMY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WORMY>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

