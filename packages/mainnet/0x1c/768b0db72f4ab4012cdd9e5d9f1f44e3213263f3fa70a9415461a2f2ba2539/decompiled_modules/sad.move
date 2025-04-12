module 0x1c768b0db72f4ab4012cdd9e5d9f1f44e3213263f3fa70a9415461a2f2ba2539::sad {
    struct SAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAD>(arg0, 4, b"Sad", b"#gLadurday", b"The fast pace of life needs a perfect Relaxation Reminder (#r&r) The sacred Love we have for each other at our family gatherings whether they be at the supper table or the halftime show. We have, together, renamed our favorite day of the week (#saturday) knowing that they are only increments of the complete \"GLADURDAY '", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.app.goo.gl/AsE5Q1TfzxKhYAXV7")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAD>(&mut v2, 70707070000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

