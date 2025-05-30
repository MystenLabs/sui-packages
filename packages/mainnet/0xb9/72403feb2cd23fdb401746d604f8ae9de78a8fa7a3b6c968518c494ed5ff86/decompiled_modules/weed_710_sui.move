module 0xb972403feb2cd23fdb401746d604f8ae9de78a8fa7a3b6c968518c494ed5ff86::weed_710_sui {
    struct WEED_710_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEED_710_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEED_710_SUI>(arg0, 9, b"weed710SUI", b"710 Staked SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRsoFAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBYAAAABDzD/ERFCSED4f9oHSkT/k3zcjZwAVlA4II4FAACwHQCdASqAAIAAPm0ylEikIqGhJRmZCIANiUAakA8vkuPx6plHOuOSf8l9yXa+8wDnq+YD9kPWZ/s3qZ9AD9Zusp9Bn9gPTe/Yj4Rv2u/bT2jDBDTTfI39W+wZ0pBrEkKQktC3II1DxJ7NqVP4+PeXS56ubuTRBdN4ahuSKFdfGWdMP7OQnEITGqmWjG6NfUyGNyx9L4f6IOWEPuXmbtqBQbjqXJpuFk33aAxOUu5Tt9tPLmJmu87zOSK89kNvX99wMiYNhyVwwKwiIeR7tCru/F6Kt201id8QJtGg8eUG185wuouJAjymWmqAU0ntbbaihJaFaAAA/vz4QAAAH/3PAYNpM6WSHvu0e4m11stcA56ZtSiXE9o/QnYafIUUW4zlrCqmik/iGU6U48e8EkBOMNknYiQ/YDCrRngeepC/r/ermw7aw4RZXIx3pqYyRHeAXP1sL2xblQ0F1uylF+vrfdMDY5MvGybFWHP/bIaRX2FcwK8KdOJLW3tHFOdJ+U9hOJkggR2KQY1r4+48r4r8t2uBXwDX7UNP1P4hkaK1a9BgpItujmWSGWCTlb1bWIjbL9clD9/4h0ibRJ+ZlG+roAdfpv3FOPuFB3pSmIUA5jZo1WGesyRrJq0dvKiLLG1oStP/pv0Q/tAT3J5LkctpP59xKtm2A2bOnKN3ubuOy/OLrJu+m0CcFiKV2D7E48T9+L5vlI0pIJwiHdImjTKA0kQlpvIMfVWMOsCqGOtBPkP7mCRGAUQ9Yz8bGOlaMsvyrI1R6b+JHaxlvKG2ydH/p8QtOWIDGw/+hJU5gG7brysSC736zhj+HafYvnFRjfn7zkle8R8WJkVK+iIAz7wkEEvBYcbQLSsfQJ/qLAE8Jdam/SMUX+qTC4beKDe/sxkenJ1xBlrrNCsC8kP22y/oDRZQPosERU+PFET3dt0mGCwTEyM5c52uetuDpAnoF6JBwR90vFL2SLf/6DCirZ8fFt/p4sm6RI+PaLoeGlQ7h6Wk1/PxH7Q2NEYmLsFs4CcKffkE85j5fFN/JcezE0rtPmLLEIktTrovDno3v0DksjpQZbT9LvmqHxPyC90GAmywSZ8PkXeVoIMXXHusYZe6zXesgOI4thEPYXGpcXiLxZMAMdZjUT8TNs7c11gQdFr6+/DHHu2ydnB21ib4IkjXvlXknqmlqreQUoeTm8aveU9dvZKpsDpQmd/tVoViVgvr62Js72K3XFh9N17+r74n1NxM1gIVOJjDPmYsFLEaRkBr1zuLBU2on9vHVcVeTNog4r17Q0ZJwn/VRwH1h2vdZ8IQzrKwNo0TN9CdNnEvWsl0hRyinruIg25enZkHX51nK8i2lWAexN+wfdBttEwg5rYys7T6qUNw7nmePJWCMi16OqH0BwPsdarI76jt8BfJUUF6JQMpC8vjd9NvobFcFKS8N+1R/uQV6RmyllVrxj2p9x5YPWCGk5mXcHNGMgcDK0h0O4AGModHc/eff8xhZpT0vUWhvWKAT0MM9+/mcaYU0cRMJS54abut1CGs8qNV2/BR7WHTYwmgMKC80SlTjbyis/olrTB2jUBquyHbs12sTePU+3iMDutvP7pgUuNxXt16tzUkdpYB+M7offOQN8cAE0kWU1j1uYX74IL8mXCctQVa8rH8dK94FbuM8o0nNLq+DUjP4nBRT7+MhP1KLK3qEmZzWH/39n5JF6wfZNQF52WTEdootUuWAJoERBJ0AZPOS1zv2wit2AISYRZKP2BGvBUjRQxDam6QHtNxKrEmqofFNoCV7JRIUR5oo5khJEKfZPvp1f1ewN/j16GxHEjyA01+AgO0Exk81RQWv6Laps8B5HC7VQpWW58ko3vSxjF1FzBlw8CbnTzvYQCDgb/Kb3ytkcoAAAAAAAA=")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEED_710_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEED_710_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

