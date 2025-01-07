module 0x5c5241421d48a8e1147384eea2ed12feee0069d414c2a368f6e2c2e94dab1519::dad {
    struct DAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAD>(arg0, 6, b"DAD", b"SUI DAD OF APTOS", b"SUIDADOFAPTOS (DAD)  The coin that Aptos can only dream of becoming! While AptosCels are busy farming airdrops, Sui is out here running the blockchain marathon like a true champion. Powered by the ultimate Move technology, Sui is the dad that shows Aptos how its done. Forget Aptos' wannabe gains.Sui is making real moves, and DAD is here to remind them who's boss. BRRRRRR to infinity while Aptos watches from the sidelines!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gigachad_Photoroom_e5c874d8ee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

