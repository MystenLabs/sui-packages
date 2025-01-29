module 0x6225bc9943da820a57d06fa560002c4c4f1d11c11d0e9b0ab61cc3560c9e2036::aped {
    struct APED has drop {
        dummy_field: bool,
    }

    fun init(arg0: APED, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<APED>(arg0, 8269780755186731709, b"SUI ApEs", b"APED", b"This is a new fresh update to Apes. Something very much needed. Hand drawn. The best thing about holding this token. Is every 30 days. 100 randomly selected holders will get Airdropped a new image ape token no matter what the market cap is. So join the telegram and make this community grow.", b"https://images.hop.ag/ipfs/QmViaeB2Jerk6yq5VR2qewdTihTyLuPHqZSyThJz1nfnTL", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/+c-04RVNw7AViZmQx"), arg1);
    }

    // decompiled from Move bytecode v6
}

