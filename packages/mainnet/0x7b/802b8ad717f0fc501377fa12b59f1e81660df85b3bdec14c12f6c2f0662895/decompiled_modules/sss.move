module 0x7b802b8ad717f0fc501377fa12b59f1e81660df85b3bdec14c12f6c2f0662895::sss {
    struct SSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSS>(arg0, 6, b"SSS", b"Sui Shit Squad", b"ui Shit Squad (SSS) is the ultimate meme token that embraces the chaos and fun of the crypto world with a lighthearted, irreverent twist. Born from the depths of the meme community, Sui Shit Squad rallies a squad of loyal degens who aren't afraid to laugh in the face of FUD, market dumps, and volatility. With a playful theme that pokes fun at the absurdities of crypto culture, SSS is a token for those who want to have fun while riding the moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sss_e5eff36754.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

