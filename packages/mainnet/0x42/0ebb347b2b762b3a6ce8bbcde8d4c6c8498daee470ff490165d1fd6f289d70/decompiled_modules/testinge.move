module 0x420ebb347b2b762b3a6ce8bbcde8d4c6c8498daee470ff490165d1fd6f289d70::testinge {
    struct TESTINGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTINGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTINGE>(arg0, 9, b"TESTINGE", b"TESTINGthat", x"54686174e2809973206120746573742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://drive.google.com/file/d/1nOLY7EZQ31aFJLVLoJlFWBxvoATnGfhX/view?usp=drivesdk")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESTINGE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTINGE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTINGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

