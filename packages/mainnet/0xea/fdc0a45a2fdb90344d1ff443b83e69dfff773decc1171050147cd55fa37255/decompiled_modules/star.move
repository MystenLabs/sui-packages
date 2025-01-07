module 0xeafdc0a45a2fdb90344d1ff443b83e69dfff773decc1171050147cd55fa37255::star {
    struct STAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAR>(arg0, 6, b"STAR", b"SUISTAR", x"546865206d6172696e6520776f726c642077617320696e2064697265206e656564206f66206c696768742c207768696368206973207768792073756973746172207761732063616c6c656420696e20757267656e746c792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fighting_47_ee6f87e4f2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

