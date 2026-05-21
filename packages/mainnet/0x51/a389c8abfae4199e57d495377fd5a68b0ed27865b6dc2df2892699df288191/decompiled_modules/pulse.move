module 0x51a389c8abfae4199e57d495377fd5a68b0ed27865b6dc2df2892699df288191::pulse {
    struct PULSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PULSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<PULSE>(arg0, 6, b"PULSE", b"Pulse", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRiwFAABXRUJQVlA4ICAFAADwFQCdASpAAEAAPm0ukUYkIqGhLhbccIANiWwArDPQUTOoJNbszkXaAOdN5gOhn5sfUAegB0u/7EWHBi150/b+7BevtH+kSjjsP2tt2KJpyHVTY8t/m+Tb6lV6P/3jxyzpExTA2YguLA6QHebwxa1XdDkaUfey6WV4u0tAnTUWtR7Wr811ZkaXzI5dLob5fEQJEZ2q0or7SigCJs7TTygxNz3Vcg5bqWB4T8h2DzIwy7mj8W/dJcAAAP7/0ZOg1saAkHpvL4zh8cRDv5pA0hJmN/PihxmEyAXMprFM71m3PfRrM0dn1jWZXSg3OWnqtaI4hXWfcQwBdu9OPczOHwFGF54O5QsBbT+h7APdNietLx+5kC9roknrl4wB7KenWbX10ZoA5zfl1okClpNIDQPa3cOgjSE0iXoE6v0Dia0+glPUGhOhgNFBbedZ83rms+/cf4p+oegeXFblDjBYPIsws862p7HUl/5ymPBfTvg/wfptBo02LVdvNvMffd6lFebiJH79fRHP1LvsGw053UfB02mnteNvHjSMZx38r/pUsFPFZaCILIBXy6gxO/z9KHzCrdgYLV8FLA1zIZS4aVeF09mLKdG3AEX8nELDU6QjEwHk1O2lj+64d1a5mO6ebJiMleBy9XEG2MW0w8MzrGN8Cj0u/qHP/AT744dDVjfKQkpsAI5VMrgwyMDB6ht97V5qnOvssoqYP9fjpt9I8yuq3+P//S4v5lWnEmh2zoOlL/e9IcZR8KJ8+T1N4pQrkCpZpqb74Z/2/wku/oTgEyVinr3qvyf2K/a1W2svgBq6pkc7ZTBXkiWDg4+1OiUYjFcaFex852pvXlblU9pIyj69wccwkCpKbx3wcZYELuaInLpiJERXTRpNwB+utKEIcBEJupf11GWvawT61hyEvRxliRjSQcYdRuM4fgUbNiLi6hx8+EIKBQcBo4U+VUkXypuSlq81NyCfEDDmw2Ad2MzYYVp2RPKy/Sftfu2482osfUowRT/wiEyDH+KYBKvCDD9iebCS6bfl8FCEHttvwh8Lv89/YXjzjz2ckPEtBmPOn9Fqwv+DIbIq2S4JKQuHg7hifZ6rR/KtDNdD2s9tfmYQ6ggsKulebbA4eIRIl/tP+Rw3IdPwsCJwMXCsmgt/V9P3BC2cwd49MrHOv44m81tFHbsNUIhJDUs9E8DArJ4AMQd/H7qrUMlfu1tAuOIwmbLW5CZnPR2ncJXWmZ4Xol4OvduYtwTEJtY9N1p/nQNk5WgnjgpZbJcL5X0zPZXa+N6FQZVh5ZqJYf8p2a+xLfr3FJGsbdSBZX5tetojfMs3xcbR5iKihM1I9nerfG0eq8vOI3TddlvVVINjB1TEOal+AXcFXKtMMH+gdCiossJXqk8qfZrAEwbIWtvtzH/PBGGnSiKO0EYQ36DIrVS1yJu1Rhv12e91K1uDISXa6byqUpiDiovgdcuXzJA3JyCd7bmiCtnwX5MQVzMU4yo9qvzK8fIvgj840allpqaWeaogwMyZQGi8WlJP7KQ6br7Y8+fHZxWmhABBFUNG8RMjrKBydDvi9uDgPeBDBEXc9KhACTW0ce5BO9rKwUXy9K7iExJBOCamrTSdlXLzdXXw0J44GRHZpdF+5G7HOUWlI1q0UOWu6/Mf1HwM4/pcGNPn2EpBm7i19Dj31XddAsnkNVsQn9Brr2PqeEHCcszgiEM44NhOlO20D2JnxjoEhlsTwbq2ZuqozCeIb1+sbemSAAAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PULSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PULSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

