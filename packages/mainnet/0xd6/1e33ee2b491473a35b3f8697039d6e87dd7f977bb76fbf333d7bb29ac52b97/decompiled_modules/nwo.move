module 0xd61e33ee2b491473a35b3f8697039d6e87dd7f977bb76fbf333d7bb29ac52b97::nwo {
    struct NWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NWO>(arg0, 6, b"NWO", b"Say NO to the NWO", x"4669676874696e6720616761696e737420746865204e657720576f726c64204f72646572207265717569726573206120626f6c642072656a656374696f6e206f66207468652073797374656d732074686174206f70707265737320616e6420636f6e74726f6c207573e2809473797374656d732064657369676e656420746f20636f6e63656e747261746520706f77657220696e207468652068616e6473206f66206120666577207768696c6520737472697070696e672061776179207468652066726565646f6d7320616e6420726967687473206f6620746865206d616e792e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732046149449.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NWO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NWO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

