module 0xa0a1e8ed6ec6bbe8b137ba185239ab4ab609d44c336eeb17724265e8f30400c5::xemp {
    struct XEMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: XEMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XEMP>(arg0, 6, b"Xemp", b"X empire", b"bot telgram", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t_A_l_A_chargement_4c15d78557.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XEMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XEMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

