module 0x97c6dff4c3d2c29e5d283981e051fc17cc5cea22b8d51af3e8a12cbc1471336e::rogie {
    struct ROGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROGIE>(arg0, 6, b"ROGIE", b"Rogie Sui", b"$ROGIE is a dog father figure who is hardworking and firm, but on the other hand he has a strong maternal and feminine spirit.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001693_e908d23d90.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROGIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROGIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

