module 0xd87613002931b8db36979bf01abcc92d553d843c73c6cc5a0cc9424bb9493b18::lastobjectid {
    public fun tx_digest(arg0: &mut 0x2::tx_context::TxContext) : vector<u8> {
        *0x2::tx_context::digest(arg0)
    }

    // decompiled from Move bytecode v6
}

