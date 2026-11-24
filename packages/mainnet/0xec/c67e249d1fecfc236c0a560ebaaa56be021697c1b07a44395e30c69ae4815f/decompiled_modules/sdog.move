module 0xecc67e249d1fecfc236c0a560ebaaa56be021697c1b07a44395e30c69ae4815f::sdog {
    struct SDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SDOG>(arg0, 6, 0x1::string::utf8(b"SDOG"), 0x1::string::utf8(b"Sui Dog"), 0x1::string::utf8(x"53756920446f6720e28094206c61756e63686564206f6e205375692066726f6d20536f6c616e61"), 0x1::string::utf8(b"https://aynb7ojmit1wvfv3.public.blob.vercel-storage.com/icons/ddc10d5e-0087-4cb4-8a3b-636480faee76.jpeg"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SDOG>>(0x2::coin_registry::finalize<SDOG>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

