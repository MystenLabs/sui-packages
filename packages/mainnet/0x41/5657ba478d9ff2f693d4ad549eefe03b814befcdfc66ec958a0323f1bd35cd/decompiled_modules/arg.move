module 0x415657ba478d9ff2f693d4ad549eefe03b814befcdfc66ec958a0323f1bd35cd::arg {
    struct ARG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARG>(arg0, 9, b"ARG", b"ARGENTINA", b"hola soy de argentina si alguien me puede ayudar se los agradeceria. y si todavia se lo preguntan si. voy a rugpulear pero por necesidad. las cosas estan mal en argentina", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMgAAAB9CAMAAADQgdxqAAAAyVBMVEV0rN////+iyOr2tA79+/r7+PbbtIHv4dXWqm338e/fwaLUr4ncuI7btojEhznbsnrasHTNiyj17efPnFfQnFPPmUfHgx3fxKm6fTrLmFzOonHPnVzjy7K0aQ3Uq3js3s3Ykg3tqQ7fmg3mog3n1MDPkja9hlLOn2bVpmLCiELPlUC4fELKkUXXmi/EjE3IizbNiBa8eCHBeQ/WnUG2dCnYtpXUkR7VmjvQpnrSo2LDgy3Bfx+xZxPLlU/GmnTHiC67fDPav6qoXAwp1W0hAAADi0lEQVR4nO3a+XLiOBAH4PTiQ3YExoccA+YKcjAmYBFjckwYmHn/hxoZZlP7ANOVcba/KlKVv5pfSbKkNjc3hBBCCCGEEEIIIYQQQgghhBBCCPn/+eeLuIEvgoL8bdCDuAG4Lhg1dh3cILcAWwc4Bz65/IMIMYgDMJCQc+h2Ia9BDvBKAWqQBwfSENIMLKuJE6aQPuBVQwzCQxN6tuFLz4OK2z0I3hy8alhB7oYAI2F6DJ7dft8+2MyDSQ4wvEMqiDYiwyUYgtl+8MwZm4jAt6cbCcslVj2cIFNbL/SRkR4C4RVWnmeWJ6YbZoz0gndw5hdSkJVrGmFkFoz7oyIMVe2/ZKEZhYbxunJRSiJNrVRkXVOIW1XHa/WYqEE8ygIhTCeMDJyKGEHMO/1l082rU5Tb+HE/3o3H+0S9FIXd30QOGHcmQlGMIMYkYRKmGyHLt9141tFm492pXKrKBcmSCcag4Ewtk5dFVxbquHvq/Pa0OysecFFaGOOBE0Q2f1yhovW3cefD+NswioVe6aYMEIpiBFkmp6yybBnF7/NOZ6E/84X+vKvjd5dzdjo+IAwKytRyAtmtVFb29MSa/aYn1zk++FXVn2KURNvZDefHcLtXOshPdX8/+6mDqPNQBg7S0xcjSLpOkv0ujpV60l9/fr/Q7vX8mj0pFce7fZKs0z9fFW9EArk8q2aVzxfNMtEjst8Of7RpRLQpqypfxefLw3cxmy0uD+BemamqK22UwxZCEPMhOjFe19+Pqnlq/Rtk/h5H0raq7HTGOAJjjEggjes+MrzuI7PLDBvv1pESlxOjRCiKM7UM3qusgKvVf3f2oypktyh5e3b261nLrdSyPH2ctfZvpRSbaavOWs3p14k2fbsoX1Siz7678X4Vb8vCed3oB297Tr+aEYWOvo8E2SAeqORRreNa1fo+0s0Ewh7SwAnirpjR3BCj7MWv4zAsQp+zorkhmu6qTUeU5l6+jAy2mQrPyvLcKzwRHNLLnd1uUxC4dFHSzdT2A+Exxp8D32bCgOUQqx5mXyu3wGP2we733WdgnilGbexr6fnVC6Bn8wo8T/pg98AMOV41zN5v2vR+ed70frO06f067ez9wqUbX+dNN17HabrxLez9Xt0CTHjzfsTZtvj9yFUNzRurAGuNf6B3iH+brxPks3+x8Kd89i9ICCGEEEIIIYQQQgghhBBCCCGEEPIJfgFxEnJ7UEbaeAAAAABJRU5ErkJggg==")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ARG>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARG>>(v1);
    }

    // decompiled from Move bytecode v6
}

