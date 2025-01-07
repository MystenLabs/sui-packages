module 0x2a937fcda93910613ef22fe01c2592d22c120fb9f72e9279f25c8333c82b9fa4::duko {
    struct DUKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUKO>(arg0, 6, b"DUKO", b"DukotokenSui", x"41696d656420746f206272696e6720616c6c2074686520646f67206c6f7665727320746f2061206c6f77206665657320636861696e207468617420656d706f7765726573206d656d657320616e6420636f6d6d756e69746965730a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ps_Fnf_N1_400x400_d3803dc388.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

