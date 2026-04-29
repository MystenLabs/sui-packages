module 0x154fea4cdc8c58b84917f50a9e89acb707a3f03113c79e2066e3025cd086c884::fork_sui {
    struct FORK_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORK_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORK_SUI>(arg0, 9, b"forkSUI", b"Fork Staked SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRmACAABXRUJQVlA4IFQCAACQEACdASqAAIAAPm02l0gkIyIhKJHoAIANiWkKFqQV82k+2V6H+S4VZSv1XzA+nXKAeG/3H6j/9j/Vn3mP7PzG/RQkuM7m3amMXofvZk+GyoZ6rd40tWLg7/wGwpXJcRwYmT2jISe5THyiDzOqfUoP3ZntMKd6u/CAKha/XSZHQ2mzzfk+WDSeOQLG+QAA/v92K3/w+IlyP+gzdaxvauaCQGn/PajJdZAkZf7UFzxYuHCnPMIohaEcf1Z40M62N/nvJkus+mGnQDf6ER1rGuWVDEP3Sb0rcdtzR+lKmhnhzIFvmDWp5MB+9AF0THn5rjOnS/7GtQvYpqry8YjyzpHezTZ7ZeNsM4KUd+0UHgKmFZRChJXgM7ljmeSileLiDQXUIl0lmY7gBeiuu6gZooPIB/RcW+KdOiuVVl3RT7pyrT3s5V/PYEFZyFpqVXBnVPvCBpK4jhbGm2YbY11GHjSQ8w4/d46Um8OXsOhSk4fNkLQ/75eG14F7WvMzODq3K2KDXOC4gP/NGQdH8fXjs84eD7eum1sCdfL7vuCTy67yoRSPAYMVO9HSbraec1SPRjDYD5oCS7+tZpF20hhvjNPLt/SU2Kmq2oLpXb62HL03gxOXfLbrlba5h5Tt9qo4DxYDj0eZms95TC9F7lJY+kTsoDDf/ZVULRlIF+lgKWCOevB7BdP5aOJU+6IUy8pQpGn+KdupN5e2lfafFm8GNv3zP703UxVQ6+dcAqHtodG3TcGxOYM8hIFQ4g7WUSylmSmAKrPWkxLdgD89ep2h2WzmUEAAAA==")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORK_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FORK_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

