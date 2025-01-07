module 0x5a63061e580bd9201443874fd50eb675a97582b0e87666caf98c382bd529f911::aquaevan {
    struct AQUAEVAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUAEVAN, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<AQUAEVAN>(arg0, 6163526351899484189, b"AquaEvan", b"AQUAEVAN", x"417175614576616e202d20496e737069726564206279204576616e576562332c20546865204c6567656e64617279205365612057617272696f7220616e6420526967687466756c204b696e67206f662054686520537569204b696e67646f6d20f09f8c8a", b"https://images.hop.ag/ipfs/QmPsjfJNEF8YvwxjHukpgAXUkY1gHgawsMsUHcATckZwfP", 0x1::string::utf8(b"https://x.com/aquaevan_sui"), 0x1::string::utf8(b"https://www.aquaevan.com/"), 0x1::string::utf8(b"https://t.me/aquaevan"), arg1);
    }

    // decompiled from Move bytecode v6
}

