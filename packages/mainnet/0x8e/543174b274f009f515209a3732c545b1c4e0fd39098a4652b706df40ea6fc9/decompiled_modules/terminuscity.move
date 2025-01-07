module 0x8e543174b274f009f515209a3732c545b1c4e0fd39098a4652b706df40ea6fc9::terminuscity {
    struct TERMINUSCITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERMINUSCITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TERMINUSCITY>(arg0, 6, b"TerminusCity", b"Terminus", b"The name of the first city on Mars created by Musk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/Terminus_adec90cc7b.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TERMINUSCITY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TERMINUSCITY>>(v1);
    }

    // decompiled from Move bytecode v6
}

