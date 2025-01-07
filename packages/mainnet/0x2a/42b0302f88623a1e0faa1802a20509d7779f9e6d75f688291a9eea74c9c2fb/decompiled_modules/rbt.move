module 0x2a42b0302f88623a1e0faa1802a20509d7779f9e6d75f688291a9eea74c9c2fb::rbt {
    struct RBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RBT>(arg0, 9, b"RBT", b"robot", b"mutated", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0eae704b-93b3-49fc-8413-51eb777f2fe7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RBT>>(v1);
    }

    // decompiled from Move bytecode v6
}

