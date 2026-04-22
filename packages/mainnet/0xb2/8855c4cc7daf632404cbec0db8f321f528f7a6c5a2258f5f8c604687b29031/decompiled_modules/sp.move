module 0xb28855c4cc7daf632404cbec0db8f321f528f7a6c5a2258f5f8c604687b29031::sp {
    struct SP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<SP>(arg0, 6, b"SP", b"SuiPakistan-Whitelist Community token", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRhgDAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBYAAAABDzD/ERGCQNJmzR/dFIeI/kcAYP09VlA4INwCAAAwEACdASqAAIAAPm02lkgkIyIhIxVbUIANiWVu3V6XYKZTzw+muvnVOCOZ3C6q8aH493rROo2UaR90Vqvnie6fU3VzXGHfc6Ji1YnRhrmjOV7TaTJ3Ki/KvgY6ov16luUClgHl8tXiHBevVTJgqchp85tJXQE79yBM7MR97bRQ69/HF2fOnI7kVlAA/veL//8epDUlX/rB9Y8BWD/+6D//442FQf//Ij1X/QJYC5dR1j9MqfTx7r0hucADrcDDLHVlO/CjCqzpkzrcQSBFbVObSVvNnpN2Pl2VhA4+oJ/1UZV7MDggQyuwHBN3QyH7AoK+VT3S6f7B+WWEgiDg7MJ99M3aELPklvHIeX/GbFMz0lao/H1fBYm047oPvflE73BH6VnX/S88NRlIhU/1miPdVM6/sqo71Mp9zWWaEIs+qRGIXOt5PUydww6j6k3xRJrSsvXRJ5Te1ykw4QZcM0vnvVbjzjml4T25UcEtayuf0vat7enO8QMA7v1DN3hMqpAWh9lUOatCrm+a5xL55Kw5VyBxC9b+wMlyzzKG9fiN7uLZOfJXH2f53knJOqh8ts7886Dn5t1j+DRA8RRkSNRBc2kpYLR3OOTW8k+8jH9/iftrTLjPOA/MoC9IjWKdubPvDc+hFxOyWtpFqu7MsGgqXSZBjvXGsmRRc0bhG9ir1p9zj/PH3bSLPMAPSdDptALKOiapQzyKL36TtCWIowqBPs8XscclnlRcMybmdE0Suw9Df0f8NWPP0cVeRb+yF6WjoTOEHjNRuU1/9NnKb0uCTcG7BpuXe2Xgf/Xr3/60Tk5rIHTbW51KeLlAdesLSQmIG5DI0YXgUilJtrxmJuPpDSKjDPYFdzV1sImCuzHMkxRefeF1pSV45d34Z+JnfVbJFjmZeTbtSeI9YWzPxBcdO/xJRLtnuLxDi3RoiSMtwd+qRAhKnwTt7i0vBWE/C84tCSU3XILx4/YAAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SP>>(v1);
    }

    // decompiled from Move bytecode v6
}

