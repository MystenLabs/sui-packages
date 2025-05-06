module 0x95f58b721cde9a00311f6213e04e2db98be3655216b7ebcacddd5707df93b37a::bshit {
    struct BSHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSHIT>(arg0, 6, b"BSHIT", b"Warren Buffett", x"48652063616c6c656420697420736869742e0a5765206d616465206974206120746f6b656e2e0a42756666657474536869742069732061206d656d652d706f776572656420726562656c6c696f6e206f6e205375692020706978656c697a65642c20646563656e7472616c697a65642c20616e6420736172636173746963616c6c7920756e73746f707061626c652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e_a_ae_a_c_e_2025_05_06_081048_01d97b65ec.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSHIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSHIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

