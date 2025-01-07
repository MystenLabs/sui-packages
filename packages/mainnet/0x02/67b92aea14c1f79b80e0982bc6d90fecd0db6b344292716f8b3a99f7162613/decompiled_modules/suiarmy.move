module 0x267b92aea14c1f79b80e0982bc6d90fecd0db6b344292716f8b3a99f7162613::suiarmy {
    struct SUIARMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIARMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIARMY>(arg0, 9, b"SUIARMY", b"Sui Army", b"Official token of Sui Army", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIARMY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIARMY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIARMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

