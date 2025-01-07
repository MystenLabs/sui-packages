module 0x4479b89d3d0a02d6e0d9c0e4c2c9969b523799ecd7f271ee3ff965f959dca0f6::peepee {
    struct PEEPEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEEPEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEEPEE>(arg0, 6, b"PEEPEE", b"PEEPEE SUI", x"4d656574205065655065652c205065706527732079656c6c6f7720636f7573696e2066726f6d207468652074726f706963732c20686520656e6a6f7973207377696d6d696e6720696e2079656c6c6f772c207761726d206c69717569647320616e642068617320646563696465642074686174206974207175616c69666965732068696d20746f206f706572617465206f6e207468652073756920636861696e2120446f6e277420776f7272792061626f75742068696d2c206865206973206a7573742074616b696e672074686520706973732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8u_p72u9_400x400_53da24288a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEEPEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEEPEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

