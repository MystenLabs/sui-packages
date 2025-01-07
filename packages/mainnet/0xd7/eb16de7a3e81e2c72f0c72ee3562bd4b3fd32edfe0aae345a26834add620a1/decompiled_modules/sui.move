module 0xd7eb16de7a3e81e2c72f0c72ee3562bd4b3fd32edfe0aae345a26834add620a1::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 6, b"Sui", b"Sui Burry", x"546865206d656d6520636f696e207265766f6c7574696f6e697a696e67207468652063727970746f20776f726c6420776974682066756e2c20636f6d6d756e6974792c20616e6420756e73746f707061626c652067726f7774682e0a426f726e2066726f6d2074686520696e7465726e657473206661766f72697465206d656d657320616e64206675656c65642062792074686520706f776572206f6620646563656e7472616c697a6174696f6e2c20537569204275727279206973206d6f7265207468616e206a757374206120646f67206974732061206d6f76656d656e742e20436f6d652020616e64206a6f696e206d6520746f2073656e642068617070696e6573732020746f20657665727920206f6e6520696e20737569206e6174696f6e206173204368726973746d617320697320636f6d696e6721", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_11_22_01_51_22_A_cheerful_American_Bully_dog_wearing_a_festive_Santa_hat_sitting_on_a_snowy_ground_with_a_background_of_a_cozy_Christmas_setting_featuring_glowing_69ec76ab2c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

