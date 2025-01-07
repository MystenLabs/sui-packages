module 0xed95be68f4c79e481fcb200f9efac09e449bab0383ef25cbcbfb2cc04cec0b82::izu {
    struct IZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: IZU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IZU>(arg0, 6, b"IZU", b"iZombie Universe", b"The iZombie Universe environment will bring together the best of  features of gaming and digital collectibles, transforming it into a  digital bio-world on SUI chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/token_2e912df85a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IZU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IZU>>(v1);
    }

    // decompiled from Move bytecode v6
}

