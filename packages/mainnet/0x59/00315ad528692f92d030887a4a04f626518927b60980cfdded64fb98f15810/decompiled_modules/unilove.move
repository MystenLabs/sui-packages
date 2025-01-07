module 0x5900315ad528692f92d030887a4a04f626518927b60980cfdded64fb98f15810::unilove {
    struct UNILOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNILOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNILOVE>(arg0, 6, b"UniLove", b"Uni love Sui", b"Uni is the name of the dog of founder of Sui Network.Let's give him  as much loooove as we can, show him the love of Sui Community!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/IMG_0824_6ad6476f93.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNILOVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNILOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

