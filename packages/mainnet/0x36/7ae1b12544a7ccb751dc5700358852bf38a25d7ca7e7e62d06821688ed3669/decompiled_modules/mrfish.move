module 0x367ae1b12544a7ccb751dc5700358852bf38a25d7ca7e7e62d06821688ed3669::mrfish {
    struct MRFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRFISH>(arg0, 6, b"MRFISH", b"Mr. Fish", x"4d656574204d722e2046697368212041206d616e20776974682061206669736820666f72206120686561642e0a0a536f72727920627574206e6f2c204d722e20466973682063616e277420627265617468206f6e207761746572206275742068652063616e2068656c7020796f75206272656174682066726f6d20796f75722074726f75626c657320776974682068697320696e74656c6c6967656e742074726164696e672e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_21_41_50_c34f30681d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

