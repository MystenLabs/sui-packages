module 0x7971e9db09d858bbb334d1d218d4cd26535142fd26b2bfd86b0686e039c7ec7b::ofs {
    struct OFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OFS>(arg0, 9, b"OFS", b"OceanOofs", b"gem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtT1J5h3-elx5iHEBXF01zm5vW_7-tfIyi2g&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OFS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OFS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

