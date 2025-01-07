module 0x698d2b77ab41868bc8bcb1e7c5f1326c44618cccfcf0433cf987cea5fc8e33f6::lolcat {
    struct LOLCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOLCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLCAT>(arg0, 9, b"LOLCAT", b"Lol Cat", b"0xdd3920e4a4228ef3481b1264d1aa27a9928d0bfd79bcc4721269372c92f5b139::cat::CAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b" https://dd.dexscreener.com/ds-data/tokens/sui/0xdd3920e4a4228ef3481b1264d1aa27a9928d0bfd79bcc4721269372c92f5b139::cat::cat.png?size=xl&key=9161df")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LOLCAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLCAT>>(v2, @0xb24420dbd7948eb723f055df1eac2706ea24f75c7b37a3d494fd6a8969e89025);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOLCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

