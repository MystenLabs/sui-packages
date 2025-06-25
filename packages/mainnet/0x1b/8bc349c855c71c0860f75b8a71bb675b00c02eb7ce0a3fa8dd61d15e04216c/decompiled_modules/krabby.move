module 0x1b8bc349c855c71c0860f75b8a71bb675b00c02eb7ce0a3fa8dd61d15e04216c::krabby {
    struct KRABBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRABBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRABBY>(arg0, 6, b"KRABBY", b"Krabby On Sui", b"Krabby is a memepowered cryptocurrency built on the blazing fast SUI Blockchain inspired by Pokemon card", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig5edcmw7zi5bmxxmxsl3xy3iahiax6cll63oel35xlgohq7y657i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRABBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KRABBY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

