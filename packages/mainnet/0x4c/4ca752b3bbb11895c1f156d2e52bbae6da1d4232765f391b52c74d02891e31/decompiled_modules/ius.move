module 0x4c4ca752b3bbb11895c1f156d2e52bbae6da1d4232765f391b52c74d02891e31::ius {
    struct IUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IUS>(arg0, 6, b"IUS", b"1L IUS", b"tfel, elbissacca dna ,eruces ,etavirp ,tsaf ,ssentwoA latseta dital ,ekam ot deniged mrof tcatnoc tramS dna niht-fo-tsrif a si $IUS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OIP_6_ba865df77b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

