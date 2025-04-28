module 0xa1b619bc7109e8996e6a7df2eec021dd743e12409cca53be2223248b0d55cd38::spi {
    struct SPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPI>(arg0, 9, b"SPI", b"Spighetti", x"546865206f6e6c79207468696e67206d657373696572207468616e206d79206c6966652c2062757420776179206d6f72652064656c6963696f75732e20547769726c2069742c20736c7572702069742c20776561722069742070726f75646c7920e280942062656361757365206469676e697479206973206f7665727261746564207768656e207061737461e280997320696e766f6c7665642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/08db0473d228cd4c33aa999e879aadb0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

