module 0x44ad03ccbb05fd5f1b287a8ee304ed0580a4af3744e22eb035b4fad11c4699dc::n0d0 {
    struct N0D0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: N0D0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<N0D0>(arg0, 6, b"N0D0", b"NOODLE CTO", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRlYEAABXRUJQVlA4IEoEAACwFwCdASqAAIAAPm00lkekIyIhKhM5SIANiUAa4xmXgPluKF16xAdonQHnFca/7npAeYBzgP/t6CPAA9yP69ewX/S/8t1gHoAeW57LP9x/5H7YZjiG50Y24N8DSNTzHfaeklmujWpEeYYeofia0DtTa5kaM5iFrMF6b8uxyowvUO42MfwoF8ENhCVuR37qKMD1guZoOlu5M3Th1+t7EMVXuxPbzv/Exto4WWrdHw2DQvO25oiR/ZiAZQgxcZEB5/vqRIGNpSAA/vwL0Az/iIdn+0w52j+F5qHjEPkiLNLtf/707ogBVwEnfP//P/+XOywOEEisqyh8su1XmKdz+BA7a5+SbP17zvwFlfTst0SJ5UOqAlECNJf6Cs56N2kVdD6U10wTI/FxjxjC42LekTHV8XQJmtCzJ1WlTvDuoHUZ2ZyKTKt67Z/zNFkQ7LQ6g+Rf1nly7OGMPQpei53u2xpFlePTuN+sI1qR9SwiBExVOTWaIdd8edaBuThe+hwpwuz/Bd+nego+TN/zZVmeP9jljPC9oI7MJFcji6FH4W8uLJtXkUGvbD2Rm8xyUbMP00ix+5Q0VliP7vqrMDYZSigsHWaUnk4hSPI+rsnRwrqe9pV/cv+Of9n0xEz8CzO8/gYpKpPxnLjCN4dxgwCYP9Y+uCGFQYkuMMTQDJDYBfAtr4t+gDe9juu0J6D8ct0yPm50WO6qTwaGU9OdHmS+7hPhgfbQ04+2T11zx4WlJKUXGjGBuCNf76fVwyLDaFRdt8zW40VTQQnpBJKf1IJjnEcuiM62fkjcMmjLbjkbsevXv0zJrHK/3kulXXRW/8AOjQyVisJzGyLMl3pcLGD4e7aNUQ4DEyrSjFNvTorrcZsqiDluJh+zZ85+YSwnXFc4O40GzLwPda4LmuybncK7/9SlyMUHr62jzLLnYTPZGN2PbLInfkcV5zgWK8j+v2zfxawv0wWDxq0o3tm1cJqGS4ULykynEeX7lUSvNJMZIvbC37CSyywXbk0Q+MttCvZ33jFwC1jA9bdUua2OdMnUsJXLDa3eCuj7spWbTslelwaYb0fXSFg+SAn3c6fmdeOxnhjbItFm56bEcD/avGBjZ1gYTVmqfT+xB5qnHzyKABPkhqe/6H/89PoXBalRuejv4pSlbfx9P3nBGZJ0Twbw02Hc9WFDWL/+ZXyDwvze/sWiv831SP2VcZzvC7z/yjF6ku5BwdYT2UoyN3RcnVGxuLsWhAjMW0ZCH1ca1Kq1FyAA12rbifoRBs9TgxO3F6aAzPJuLkS3TGLh9lFrH79AO7QR830pjQFTsQmHb8UoxlOKuM7EnDvqEoFBi3woRf0cspCjj+EPIXWKQDqzMn0alccwrPF5HN6SKg2lZIaXQoFQiP4DqubkIf0dV5xReI+cGvwdxpMLizNCxY+8WtgwYen+0LNi79nuiloZ2eHPK/oVVBux78PV0AAAAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<N0D0>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<N0D0>>(v1);
    }

    // decompiled from Move bytecode v6
}

