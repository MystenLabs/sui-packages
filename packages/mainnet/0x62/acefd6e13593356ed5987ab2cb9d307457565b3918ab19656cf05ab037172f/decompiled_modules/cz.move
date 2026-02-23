module 0x62acefd6e13593356ed5987ab2cb9d307457565b3918ab19656cf05ab037172f::cz {
    struct CZ has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<CZ>, arg1: 0x2::coin::Coin<CZ>) {
        0x2::coin::burn<CZ>(arg0, arg1);
    }

    fun init(arg0: CZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CZ>(arg0, 6, b"BROCOLI", b"CZ", x"46726f6d20435ae2809973206265737420667269656e6420746f2074686520686f7474657374206d656d6520636f696e206f6e20424e4220436861696ee280942442524f43434f4c49206973206865726520746f2074616b65206f7665722120506f77657265642062792046696e616e63652026205765616c74682e2054686520667574757265206f6620646563656e7472616c697a65642066696e616e636520697320686572652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/rpDIKAq.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CZ>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CZ>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

