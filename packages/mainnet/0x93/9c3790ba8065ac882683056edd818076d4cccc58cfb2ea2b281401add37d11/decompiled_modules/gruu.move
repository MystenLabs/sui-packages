module 0x939c3790ba8065ac882683056edd818076d4cccc58cfb2ea2b281401add37d11::gruu {
    struct GRUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRUU>(arg0, 9, b"GRUU", b"DinoSui Coin", b"DinoSui is a unique and immersive NFT project that brings dinosaurs back to life in the digital world. DinoSui allows users to collect and trade one-of-a-kind, fully animated dinosaur NFTs. Each dinosaur NFT is unique and fully owned by the collector, allowing them to showcase their collection on the DinoSui platform or on other compatible NFT marketplaces.", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GRUU>(&mut v2, 600000000 * 0x2::math::pow(10, 9), 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRUU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRUU>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

