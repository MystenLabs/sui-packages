module 0x44f7a4373aff6c9298dde660aebe7889364e9179d562fc507e7b4b1cac681c84::gas {
    struct GAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<GAS>(arg0, 6, b"GAS", b"Natural Gas", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRnADAABXRUJQVlA4IGQDAABQEwCdASqAAIAAPm02lkgkIyIhJZXaGIANiWkAFtJ+GLI2MCtJlxaVyaL5Hn3ZJcpQESL/nQ/mfjihsa8WMwrOhzDa27h68XmCqWanAjN7BUD7T7hLTtpr8cBT69Wqy+84MnJlHjKhLBnW0OQNuBBn/0U+GguKdMT3ETflFl3QzlynJhFEvhKYsgnVUsIVEsxXyZ/YCrWa+g2cYmvLvhUWXbAAAP78rRE0ohp4Us6HxKKdvWVrBUToezkLsf7undLqVbBv1soNJtiCkKZd+4TRLHG1H+nW8ZXG7Nk6wW6MLMVQLewOgtWyNNYabwV7X4el9JSIndWh3z7O7nJAM00TiHKZW8eBwC+Jf2cvFWkP9bqTe0g8ekwOUb1LKKdJkWkriHphui6+iqGXGV2GpRgYeffD/xAiAqCXwEBXlb7dKUcfv6fOnBo99E41AHdb6N/4+cICH7v97WgbJCAClg7TI/qFaD6zXbu4dG2raJVrX1UoLgDf9OnMfoO+CqItw/CosWToANBlrlNgO3ozwujxmJXZLEN86xc/whSFft4CZ57HHIruHI5ewlpv22mkP32XPiUvhGjTEB8MEyrY0BR8wDHktKnhWXzcDCU2GWnARVcfnYnr8NhmTVEXrGRmWELIXGLJhonYxidensJfLbGcAYJwavuQsxoQYtawh5brxU+MxEHrGxF/jsXfh8HXsU7w6yNSpmVWL1/7LVtv+XMp9E5G3wCuRr48zCBUqlMxkcjiaxqO5Qk8w+E4SUT4wDUPZ8nXUesCg/t/RjIwmB8VxeIjqYCdCkXsEY2I+iBhGDsPOu8w3qL+UDQG1NQCTGZraVWeeDlC+6cSSK7cuvpw1mFvm9p/Qrd83qzk+ZA6wOo+Zi5SPRNQ6DPizNveviA2L91k7UbSp0pKHoeixFkKiR+mUhmsBrpPQSXrU+umJwzTWfVksab0FmT32+C5vpg3M3bqaHVbNBIfWZHNi9iBcyyTCdXRVNvvqOlP2iUuAqozplyI8HoYhTrKjYDtZ9mtKuYRCrlyxGVmtT7bvf3ZVaiGMHDphg3kkXUzuyCi+gxrfk/Siu5tP9BuYfOo3xHzwCqlSzZSJGG+bjLKuL6YRXHuQbHi2xr00SwcFIKLu4FEHCexB0X93DrYDWCxZAAAAAAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

