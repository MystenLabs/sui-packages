module 0x3210b15f71d0281a4225082eb1947ab96d83dd0d4ee08e3490b04278ea4c0881::cussbuddy {
    struct CUSSBUDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUSSBUDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUSSBUDDY>(arg0, 6, b"CussBuddy", b"CussBuddy AI", b"Cuss Buddy AI powered by CrxB-l3-r1-8b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihuxdcanshode5kccaiugidqyfeaighs257t5o5rdc5hwnw3ye6uy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUSSBUDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CUSSBUDDY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

