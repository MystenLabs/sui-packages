module 0x16e92be75a26c0a9b4728fdf664d1053e9937197388a9688b86f3ef6af90985f::elonma {
    struct ELONMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONMA>(arg0, 9, b"ELONMA", b"elon ma", b"elonma", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/HwcFmaNZmAjJyj4aEJuC52QrSpU9gawFhsJeehEwpump.png?size=xl&key=c82521")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ELONMA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONMA>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELONMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

