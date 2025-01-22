module 0xaa7dddadc8498cf5d504739a56a22cd82c8925e2ffc796063c6f798ad82d9684::air {
    struct AIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIR, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<AIR>(arg0, 17789554535664272176, b"AIRDROP", b"AIR", b"Hello shrimp! I'm sure you've always dreamed of getting a share of the whale's kush! I'm giving you this opportunity! Many accounts are already preparing to take a large share of the NAVI, alpha fi, and many other sui projects, and KDX is already staking and waiting in the wings. When the drops are received and the coins are unlocked, some of them will be used to redeem the AIR token! I'm giving you this chance, USE IT!", b"https://images.hop.ag/ipfs/QmZv3GfjPgMjXikfJyHrFYg1SnQsgaiLaWnQFu5gmX3PoZ", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

