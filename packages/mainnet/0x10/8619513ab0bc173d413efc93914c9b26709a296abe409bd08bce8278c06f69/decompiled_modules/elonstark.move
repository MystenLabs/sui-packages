module 0x108619513ab0bc173d413efc93914c9b26709a296abe409bd08bce8278c06f69::elonstark {
    struct ELONSTARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONSTARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONSTARK>(arg0, 9, b"ELONSTARK", b"ELON STARK", b"https://t.me/ElonStarkSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://scontent.xx.fbcdn.net/v/t1.15752-9/462535672_1360874238226198_4984919645759342019_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=0024fc&_nc_eui2=AeHHvqVkheBLZFtokWKXv8EccGwPcbOL_NpwbA9xs4v82qDO1YrK4ifLBREYlj6sMWo9eq-tJ-oBwGGSvZYSooSx&_nc_ohc=VEKIU6vHtKcQ7kNvgGLfVoj&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent.xx&_nc_gid=ADzoW-vkqC6Ho-6eHn1qDBi&oh=03_Q7cD1QF_BFlJpven-c_IyFwLnuF4qtkAJiTwSXdNQdKIPT1mXA&oe=672DB818")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ELONSTARK>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONSTARK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELONSTARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

