module 0x62e12323356971e66eb22808fd428c48be428110a755af4845a7665403ed8dc1::batcat {
    struct BATCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BATCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BATCAT>(arg0, 6, b"BATCAT", b"Brucat Wanye", b"miaw miaw miaw ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AA_7_AF_416_7733_457_C_938_D_F38_F00_A49627_6b940a329d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BATCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BATCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

