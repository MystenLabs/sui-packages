module 0x814daa52542185ad53f6415cdcbd7429d65bd3dce9af0e1502c4faa00ed78735::peg {
    struct PEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEG>(arg0, 6, b"PEG", b"PEG ON SUI", b"YOU CAN NEVER $PEG ENOUGH MEME COINS!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/t_J_Ac_VU_5c_400x400_eed7b01917.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEG>>(v1);
    }

    // decompiled from Move bytecode v6
}

