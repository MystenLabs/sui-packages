module 0xa60d595f56123a886634b548258e5df46cca77e6ef54a6df6453ef2f893326df::blg {
    struct BLG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLG>(arg0, 9, b"BLG", b"BeluGA", b"Beluga", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.wixstatic.com/media/5c7e49_4fe650c8727f4fbb8aebed39038adf84~mv2.jpg/v1/fill/w_640,h_618,al_r,q_85,usm_1.20_1.00_0.01,enc_avif,quality_auto/5c7e49_4fe650c8727f4fbb8aebed39038adf84~mv2.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLG>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLG>>(v1);
    }

    // decompiled from Move bytecode v6
}

