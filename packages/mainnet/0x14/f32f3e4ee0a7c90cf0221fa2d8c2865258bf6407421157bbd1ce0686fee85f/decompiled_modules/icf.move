module 0x14f32f3e4ee0a7c90cf0221fa2d8c2865258bf6407421157bbd1ce0686fee85f::icf {
    struct ICF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICF>(arg0, 9, b"ICF", b"ICE COFFEE", b"ice creams and coffees are two best things in the world and we want to mix them toghether but we don not have enough courage and money support us.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/840ed008-ff3a-44e3-a1bb-3ea4c087b9fd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ICF>>(v1);
    }

    // decompiled from Move bytecode v6
}

