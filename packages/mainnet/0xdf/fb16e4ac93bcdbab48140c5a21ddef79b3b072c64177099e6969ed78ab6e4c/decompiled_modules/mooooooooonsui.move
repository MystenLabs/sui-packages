module 0xdffb16e4ac93bcdbab48140c5a21ddef79b3b072c64177099e6969ed78ab6e4c::mooooooooonsui {
    struct MOOOOOOOOONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOOOOOOOONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOOOOOOOONSUI>(arg0, 6, b"MOOOOOOOOONSUI", b"JUST A SUI TOKEN WITHOUT DEV TOKEN", x"492057415320424f5245442054484154275320574859204352454154494e4720544849532e0a0a77656273697465206c697665206f6e203330206d696e75746573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreialmd67xa24vzmohrfv2dcnxxhd3kgdaqbhoizippaxlyqfawxj7m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOOOOOOOONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOOOOOOOOONSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

