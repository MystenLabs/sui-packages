module 0x860b3cdf6eef1a9bca7e47cc3226c71d6a0943b6f647d18019bdf4624faea0e::gator {
    struct GATOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GATOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GATOR>(arg0, 6, b"GATOR", b"GATOR ON SUI", x"244741544f5220697320612077696c6420616e642066756e20636f6d6d756e6974792d64726976656e206d656d6520636f696e206f6e207468652053554920626c6f636b636861696e2e204f6666696369616c202d20556e6f6666696369616c206d6f766570756d70206d6173636f74652e20496e7370697265642062792074686520726573696c69656e7420616e642066696572636520737069726974206f6620616c6c696761746f72732c20244741544f5220656d706f776572732069747320686f6c6465727320746f2074687269766520696e207468652063727970746f207377616d70210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ga_Wo_No_RW_4_AA_Nn8_H_a0f92abdee_19425fba13.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GATOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GATOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

