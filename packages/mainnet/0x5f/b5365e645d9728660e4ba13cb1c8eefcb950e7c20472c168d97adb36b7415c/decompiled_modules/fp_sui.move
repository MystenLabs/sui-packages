module 0x5fb5365e645d9728660e4ba13cb1c8eefcb950e7c20472c168d97adb36b7415c::fp_sui {
    struct FP_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FP_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FP_SUI>(arg0, 9, b"fpSUI", b"FP Staked SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRowDAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSDcAAAABV0AkQPL/nNkZRhPciIgQzRkUpiLZeBFooIIwIvgXQQQhtH0BXkT/JwDksfKfAObkeSC3KfJ+AFZQOCAuAwAAMBYAnQEqgACAAD5tMpNGJCMhoS+UKLiADYlpABbQPi3ssXdXgxpXJnHkqewFNznuxEW0+dcAP0xAHHw2ucbAZlNUdyVjgLE8WbdmO5KC/6ZYf6ASiuRzwBkVgX+0ZwBaT5vtojLxYpF9aMKB+8EfaxP0S4EYoiOVTHwNjo6Bci5En/hbO5PH0aLGcpztM9LybD4nEt7Ix+quk0wIWy9RtOxT5JEYSfAz13toyONt9VatxLd4VwzQnX+AAP7614HAjshQeDpmU0U7VAF2u2JOcY6uZ92R8pLV4qMnTl38UP0b28qi08dRUbLRp9QRWNXwsSg605oNpWKZx7zfn+I54NOxuf/QsPhTzJN4GbTfeRc/uc4SIBq4wPPrJ9R92Xqj676gGpVc60fQihfDh9JahZSfYXvVsuYi3Z+tAIhs/Jd7Tl45Mj6EHjhMOdZNtD9+c0SeSPwMGg5eTtz21sUAZedcuZ1niIAP8E1colAgIVTgJyE6867CVjX7kDQ9/CctSBOOcf3x8lymlES7FPOoYc5s5RXJBtbbawYscwMLXlOObJti4SSb9OFMIxBhblN7u3JVI0yp/fZ3Y9cKHrrG3ERBnTyKs3SOxSiv7iXiaVdXZanrByevZ7/6gWn3KM5KFj4YI+J2kaOQCVoJvSSWhJPkmzBGxgHNq8Fphe/ht0/d9oYTg8k484Lh1KL2z44y71pzkYkNwl2/t2XQIfiPYVj5j/pDvn6jpGeVbO6ovYTxbb39TiT6Cg9G1YNmFU0LEFBqoJNiX869GA8tNU8aN/ytu1H7e/TTK36vjPt7pllZahZaH34/nMYEFzcv8/YIeSR7W+9k3i4n/GNwJ/Yjwa5HoKKur8NHg8TfOSSOjnnl8BZI2bRJ6l/L2spf7xRFTr7tXZ1n+V3mmsdq/MGwszi/ZSolTl3/YwUUSMz4nfvYfFXbZmm2OoMl/EnGhoKfKdPR9Nk0vIlhYRiRw7QSx3UfMlzTkW8tGo7a4RtVpHyDQXYyUkAUmSJPOjhtdbdj3YdrpRz+iG7jnfxgvJV33IDoyE6LYyXvTZhF9PB7SZyGa7nhZOUFW1OUAAAAAA==")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FP_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FP_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

